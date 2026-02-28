<div class="fixed inset-0 bg-gray-900/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
    <div class="bg-white rounded-xl shadow-xl w-full max-w-3xl max-h-[90vh] overflow-y-auto">

        {{-- Header --}}
        <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
            <flux:heading size="lg">Create New Teacher</flux:heading>
            <flux:button wire:click="$dispatch('closeModal')"
                         variant="ghost"
                         size="sm"
                         icon="x-mark"
                         class="text-gray-400" />
        </div>

        {{-- Form --}}
        <form wire:submit.prevent="save" class="p-6 space-y-6">

            {{-- Account Info --}}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <flux:input wire:model="name"
                            label="Full Name"
                            placeholder="e.g. Jane Doe" />

                <flux:input wire:model="email"
                            type="email"
                            label="Email"
                            placeholder="e.g. jane@example.com" />

                <flux:input wire:model="password"
                            type="password"
                            label="Password"
                            placeholder="Minimum 8 characters" />

                <flux:input wire:model="gender"
                            label="Gender"
                            placeholder="e.g. Female" />
            </div>

            {{-- Teacher Info --}}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <flux:input wire:model="major"
                            label="Major"
                            placeholder="Mathematics" />

                <flux:input wire:model="year"
                            label="Year"
                            placeholder="2025" />

                <flux:input wire:model="schedule"
                            label="Schedule"
                            placeholder="Mon, Wed, Fri" />

                <flux:input wire:model="phone"
                            label="Phone"
                            placeholder="123-456-7890" />

                <flux:input wire:model="faculty"
                            label="Faculty"
                            placeholder="Faculty of Science" />
            </div>

            {{-- Actions --}}
            <div class="flex justify-end gap-3 pt-4 border-t border-gray-100">
                <flux:button wire:click="$dispatch('closeModal')" variant="ghost">
                    Cancel
                </flux:button>

                <flux:button type="submit" variant="primary">
                    <span wire:loading.remove wire:target="save">Create Teacher</span>
                    <span wire:loading wire:target="save">Saving...</span>
                </flux:button>
            </div>
        </form>
    </div>
</div>
