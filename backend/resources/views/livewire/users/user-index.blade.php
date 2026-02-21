<div>
    <x-slot name="header">
        <flux:heading size="xl">User Management</flux:heading>
        <flux:subheading>Manage team members, roles, and account access</flux:subheading>
    </x-slot>

    <div class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-4">

            {{-- Flash Message --}}
            @if (session()->has('message'))
                <flux:callout variant="success" icon="check-circle" dismissible>
                    {{ session('message') }}
                </flux:callout>
            @endif

            <div class="bg-white rounded-xl border border-zinc-200 shadow-sm overflow-hidden">

                {{-- Toolbar --}}
                <div class="flex items-center justify-between gap-3 px-5 py-4 border-b border-zinc-200">
                    <div class="flex items-center gap-3">
                        <flux:input
                            wire:model.live.debounce.300ms="search"
                            icon="magnifying-glass"
                            placeholder="Search users…"
                            size="sm"
                            class="w-56"
                        />

                        <flux:select wire:model.live="role" size="sm" class="w-36">
                            <flux:select.option value="">All Roles</flux:select.option>
                            <flux:select.option value="admin">Admin</flux:select.option>
                            <flux:select.option value="user">User</flux:select.option>
                        </flux:select>

                        @if(count($selected) > 0)
                            <flux:button wire:click="confirmBulkDelete" variant="danger" size="sm">
                                Delete ({{ count($selected) }})
                            </flux:button>
                        @endif
                    </div>

                    <flux:button wire:click="openCreateModal" variant="primary" size="sm">Add User</flux:button>
                </div>

                {{-- Table --}}
                <flux:table :paginate="$this->users">
                    <table class="w-full text-sm text-left">
                        <colgroup>
                            <col style="width: 36px;">
                            <col style="width: 48px;">
                            <col style="width: 220px;">
                            <col>
                            <col style="width: 90px;">
                            <col style="width: 130px;">
                            <col style="width: 160px;">
                        </colgroup>
                        <thead>
                            <tr class="border-b border-zinc-200 bg-zinc-50 text-xs font-semibold uppercase tracking-wide text-zinc-500">
                                <th class="px-3 py-3">
                                    <flux:checkbox wire:model.live="selectAll" />
                                </th>
                                <th class="px-3 py-3 cursor-pointer hover:text-zinc-700" wire:click="sort('id')">#</th>
                                <th class="px-3 py-3 cursor-pointer hover:text-zinc-700" wire:click="sort('name')">Name</th>
                                <th class="px-3 py-3 cursor-pointer hover:text-zinc-700" wire:click="sort('email')">Email</th>
                                <th class="px-3 py-3 cursor-pointer hover:text-zinc-700" wire:click="sort('role')">Role</th>
                                <th class="px-3 py-3 cursor-pointer hover:text-zinc-700" wire:click="sort('created_at')">Joined</th>
                                <th class="px-3 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-zinc-100">
                            @forelse ($this->users as $user)
                                <tr class="hover:bg-zinc-50 transition-colors">
                                    <td class="px-3 py-3">
                                        <flux:checkbox wire:model.live="selected" value="{{ $user->id }}" />
                                    </td>
                                    <td class="px-3 py-3 text-zinc-400 tabular-nums">{{ $user->id }}</td>
                                    <td class="px-3 py-3">
                                        <div class="flex items-center gap-3">
                                            <img
                                                class="h-8 w-8 rounded-full object-cover ring-1 ring-zinc-200 shrink-0"
                                                src="https://ui-avatars.com/api/?name={{ urlencode($user->name) }}&background=6366f1&color=ffffff&size=64&bold=true&font-size=0.4"
                                                alt="{{ $user->name }}"
                                            />
                                            <span class="font-medium text-zinc-900 truncate">{{ $user->name }}</span>
                                        </div>
                                    </td>
                                    <td class="px-3 py-3 text-zinc-500">{{ $user->email }}</td>
                                    <td class="px-3 py-3">
                                        @if(($user->role ?? 'user') === 'admin')
                                            <flux:badge color="red" size="sm">Admin</flux:badge>
                                        @else
                                            <flux:badge color="blue" size="sm">User</flux:badge>
                                        @endif
                                    </td>
                                    <td class="px-3 py-3 text-zinc-400">{{ $user->created_at?->format('M j, Y') ?? '—' }}</td>
                                    <td class="px-3 py-3">
                                        <div class="flex items-center gap-2">
                                            <flux:button wire:click="openEditModal({{ $user->id }})" size="sm" variant="ghost">Edit</flux:button>
                                            <flux:button wire:click="confirmDelete({{ $user->id }})" size="sm" variant="danger">Delete</flux:button>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="px-3 py-16 text-center text-zinc-400">
                                        <p class="text-sm font-medium">No users found</p>
                                        <p class="text-xs mt-1">Try adjusting your search or filters</p>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
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
    <flux:modal name="confirm-delete" class="min-w-[22rem] space-y-6">
        <div>
            <flux:heading size="lg">Delete this user?</flux:heading>
            <flux:subheading>This action cannot be undone. The user will be permanently removed.</flux:subheading>
        </div>
        <div class="flex justify-end gap-2">
            <flux:modal.close>
                <flux:button variant="ghost">Cancel</flux:button>
            </flux:modal.close>
            <flux:button wire:click="deleteUser" variant="danger">Delete</flux:button>
        </div>
    </flux:modal>

    {{-- Bulk Delete Confirm Modal --}}
    <flux:modal name="confirm-bulk-delete" class="min-w-[22rem] space-y-6">
        <div>
            <flux:heading size="lg">Delete selected users?</flux:heading>
            <flux:subheading>This action cannot be undone. All selected users will be permanently removed.</flux:subheading>
        </div>
        <div class="flex justify-end gap-2">
            <flux:modal.close>
                <flux:button variant="ghost">Cancel</flux:button>
            </flux:modal.close>
            <flux:button wire:click="deleteSelected" variant="danger">Delete Selected</flux:button>
        </div>
    </flux:modal>

</div>
