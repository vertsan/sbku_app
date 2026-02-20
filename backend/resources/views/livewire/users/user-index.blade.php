<div>
    <x-slot name="header">
        <flux:heading size="xl">User Management</flux:heading>
    </x-slot>

    <div class="py-8">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            {{-- Flash --}}
            @if (session()->has('message'))
                <div class="mb-4 flex items-center gap-2 p-3 rounded-lg border border-green-200 bg-green-50 text-green-800 text-sm">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    {{ session('message') }}
                </div>
            @endif

            <div class="bg-white shadow-sm rounded-xl p-6">

                {{-- Toolbar --}}
                <div class="flex flex-row items-center justify-between gap-3 mb-5">
                    <div class="relative w-full max-w-sm">

                        <input
                            wire:model.live.debounce.300ms="search"
                            type="text"
                            placeholder="Search by name or email..."
                            class="w-full border border-gray-300 rounded-lg pl-9 pr-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"
                        />
                    </div>

                    <flux:button wire:click="openCreateModal" variant="primary" icon="plus">
                        Add User
                    </flux:button>
                </div>

                {{-- Flux Table --}}
                <flux:table :paginate="$this->users">
                    <flux:table.columns>
                        <flux:table.column
                            sortable
                            :sorted="$sortBy === 'id'"
                            :direction="$sortDirection"
                            wire:click="sort('id')"
                        >
                            #
                        </flux:table.column>

                        <flux:table.column
                            sortable
                            :sorted="$sortBy === 'name'"
                            :direction="$sortDirection"
                            wire:click="sort('name')"
                        >
                            Name
                        </flux:table.column>

                        <flux:table.column
                            sortable
                            :sorted="$sortBy === 'email'"
                            :direction="$sortDirection"
                            wire:click="sort('email')"
                        >
                            Email
                        </flux:table.column>

                        <flux:table.column
                            sortable
                            :sorted="$sortBy === 'role'"
                            :direction="$sortDirection"
                            wire:click="sort('role')"
                        >
                            Role
                        </flux:table.column>

                        <flux:table.column class="text-right">
                            Actions
                        </flux:table.column>
                    </flux:table.columns>

                    <flux:table.rows>
                        @forelse ($this->users as $user)
                            <flux:table.row :key="$user->id">

                                <flux:table.cell class="text-zinc-400 text-xs">
                                    {{ $user->id }}
                                </flux:table.cell>

                                <flux:table.cell variant="strong">
                                    {{ $user->name }}
                                </flux:table.cell>

                                <flux:table.cell>
                                    {{ $user->email }}
                                </flux:table.cell>

                                <flux:table.cell>
                                    <flux:badge
                                        size="sm"
                                        color="{{ ($user->role ?? 'user') === 'admin' ? 'red' : 'blue' }}"
                                        inset="top bottom"
                                    >
                                        {{ $user->role ?? 'user' }}
                                    </flux:badge>
                                </flux:table.cell>

                                <flux:table.cell class="text-right">
                                    <div class="flex items-center justify-end gap-2">
                                        <flux:button
                                            wire:click="openEditModal({{ $user->id }})"
                                            size="sm"
                                            icon="pencil"
                                        >
                                            Edit
                                        </flux:button>
                                        <flux:button
                                            wire:click="confirmDelete({{ $user->id }})"
                                            size="sm"
                                            variant="danger"
                                            icon="trash"
                                        >
                                            Delete
                                        </flux:button>
                                    </div>
                                </flux:table.cell>

                            </flux:table.row>
                        @empty
                            <flux:table.row>
                                <flux:table.cell colspan="5" class="py-12 text-center text-zinc-400">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 mx-auto mb-3 text-zinc-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0"/>
                                    </svg>
                                    <p class="text-sm font-medium">No users found</p>
                                    <p class="text-xs mt-1">Try adjusting your search or add a new user.</p>
                                </flux:table.cell>
                            </flux:table.row>
                        @endforelse
                    </flux:table.rows>
                </flux:table>

            </div>
        </div>
    </div>

    {{-- Create Modal --}}
    @if ($showCreateModal)
        <livewire:users.user-create :key="'create'" />
    @endif

    {{-- Edit Modal --}}
    @if ($showEditModal && $editUserId)
        <livewire:users.user-edit :userId="$editUserId" :key="'edit-'.$editUserId" />
    @endif

    {{-- Delete Confirm Modal --}}
    <flux:modal name="confirm-delete" class="min-w-[22rem]">
        <div class="space-y-4">
            <flux:heading size="lg">Delete user?</flux:heading>
            <flux:subheading>This action cannot be undone. The user will be permanently removed.</flux:subheading>
            <div class="flex justify-end gap-2 pt-2">
                <flux:modal.close>
                    <flux:button variant="ghost">Cancel</flux:button>
                </flux:modal.close>
                <flux:button wire:click="deleteUser" variant="danger">
                    Yes, Delete
                </flux:button>
            </div>
        </div>
    </flux:modal>

</div>
