/******************************************************************************
 * Copyright © 2013-2019 The Komodo Platform Developers.                      *
 *                                                                            *
 * See the AUTHORS, DEVELOPER-AGREEMENT and LICENSE files at                  *
 * the top-level directory of this distribution for the individual copyright  *
 * holder information and the developer policies on copyright and licensing.  *
 *                                                                            *
 * Unless otherwise agreed in a custom licensing agreement, no part of the    *
 * Komodo Platform software, including this file may be copied, modified,     *
 * propagated or distributed except according to the terms contained in the   *
 * LICENSE file                                                               *
 *                                                                            *
 * Removal or modification of this copyright notice is prohibited.            *
 *                                                                            *
 ******************************************************************************/

#pragma once

//! PCH Headers
#include "atomic.dex.pch.hpp"

namespace atomic_dex
{
    using mm2_started                 = entt::tag<"mm2_started"_hs>;
    using gui_enter_trading           = entt::tag<"gui_enter_trading"_hs>;
    using gui_leave_trading           = entt::tag<"gui_leave_trading"_hs>;
    using mm2_initialized             = entt::tag<"mm2_running_and_enabling"_hs>;
    using enabled_coins_event         = entt::tag<"gui_enabled_coins"_hs>;
    using enabled_default_coins_event = entt::tag<"gui_enabled_default_coins"_hs>;
    using change_ticker_event         = entt::tag<"gui_change_ticker"_hs>;
    using tx_fetch_finished           = entt::tag<"gui_tx_fetch_finished"_hs>;
    using refresh_update_status       = entt::tag<"gui_refresh_update_status"_hs>;
    using process_orders_finished     = entt::tag<"gui_process_orders_finished"_hs>;
    using process_swaps_finished      = entt::tag<"gui_process_swaps_finished"_hs>;

    struct refresh_ohlc_needed
    {
        bool is_a_reset;
    };

    struct start_fetching_new_ohlc_data
    {
        bool is_a_reset;
    };

    struct ticker_balance_updated
    {
        std::string ticker;
    };

    struct coin_enabled
    {
        std::string ticker;
    };

    //! Event when paprika fetch all the data of this specific coin
    struct coin_fully_initialized
    {
        std::string ticker;
    };

    struct coin_disabled
    {
        std::string ticker;
    };

    struct orderbook_refresh
    {
        std::string base;
        std::string rel;
    };
} // namespace atomic_dex
