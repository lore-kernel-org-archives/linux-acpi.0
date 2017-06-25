From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V4] acpi: acpica: fix acpi parse and parseext cache leaks
Date: Sun, 25 Jun 2017 19:13:19 +0300
Message-ID: <CAHp75VfssiqaMG0Qm_0EG1pMotGg5pMt1_bZobAFYkoRUv1W3w@mail.gmail.com>
References: <1498210597-112293-1-git-send-email-kkamagui@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36680 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdFYQNV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jun 2017 12:13:21 -0400
In-Reply-To: <1498210597-112293-1-git-send-email-kkamagui@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seunghun Han <kkamagui@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 23, 2017 at 12:36 PM, Seunghun Han <kkamagui@gmail.com> wrote:
> I'm Seunghun Han, and I work for National Security Research Institute of
> South Korea.


> -                                       /* Clean up */
> -                                       do {
> -                                               if (op) {
> -                                                       status2 =
> -                                                           acpi_ps_complete_this_op
> -                                                           (walk_state, op);
> -                                                       if (ACPI_FAILURE
> -                                                           (status2)) {
> -                                                               return_ACPI_STATUS
> -                                                                   (status2);
> -                                                       }
> -                                               }
> -
> -                                               acpi_ps_pop_scope(&
> -                                                                 (walk_state->
> -                                                                  parser_state),
> -                                                                 &op,
> -                                                                 &walk_state->
> -                                                                 arg_types,
> -                                                                 &walk_state->
> -                                                                 arg_count);
> -
> -                                       } while (op);

I didn't get, do you send an incremental patch as a new version?!

-- 
With Best Regards,
Andy Shevchenko
