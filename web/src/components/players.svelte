<script lang="ts">
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
</script>

{#if $data.players}
  <div>
    <div class="mb-1 select-none font-bold uppercase">{$locales.players}</div>

    <div class={cn('grid gap-1', $config.playerColumns === 1 ? 'grid-cols-1' : 'grid-cols-2')}>
      {#each $data.players as player (player)}
        <div
          class={cn(
            'flex items-center justify-between gap-2 rounded-md bg-hypen-gray-200 px-2',
            $config.uppercaseNames && 'uppercase',
            $config.compactPlayers ? 'py-1' : 'py-2'
          )}
        >
          <span class="truncate">{player.name ?? $locales.anonymous_player}</span>
          {#if player.id !== undefined}
            <span class="min-w-9 flex-shrink-0 select-none rounded-md bg-hypen-gray-300 px-2 text-center">{player.id}</span>
          {/if}
        </div>
      {/each}
    </div>
  </div>
{/if}
