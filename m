From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Ensure lock is acquired before accessing ec struct members
Date: Fri, 15 Nov 2013 23:42:43 +0100
Message-ID: <5300176.cL70lB1Tyt@vostro.rjw.lan>
References: <1384544489-18098-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54139 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752979Ab3KOWaL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2013 17:30:11 -0500
In-Reply-To: <1384544489-18098-1-git-send-email-olof@lixom.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Puneet Kumar <puneetster@chromium.org>, Feng Tang <feng.tang@intel.com>

On Friday, November 15, 2013 11:41:29 AM Olof Johansson wrote:
> From: Puneet Kumar <puneetster@chromium.org>
> 
> A bug was introduced by commit b76b51ba0cef ('ACPI / EC: Add more debug
> info and trivial code cleanup') that erroneously caused the struct member
> to be accessed before acquiring the required lock.  This change fixes
> it by ensuring the lock acquisition is done first.
> 
> Found by Aaron Durbin <adurbin@chromium.org>
> 
> Fixes: b76b51ba0cef ('ACPI / EC: Add more debug info and trivial code cleanup')
> References: http://crbug.com/319019
> Signed-off-by: Puneet Kumar <puneetster@chromium.org>
> Reviewed-by: Aaron Durbin <adurbin@chromium.org>
> [olof: Commit message reworded a bit]
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: <stable@vger.kernel.org> # 3.8+

Queued up for the next ACPI pull request, thanks guys!

> ---
>  drivers/acpi/ec.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index d5309fd..ba5b56d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -173,9 +173,10 @@ static void start_transaction(struct acpi_ec *ec)
>  static void advance_transaction(struct acpi_ec *ec, u8 status)
>  {
>  	unsigned long flags;
> -	struct transaction *t = ec->curr;
> +	struct transaction *t;
>  
>  	spin_lock_irqsave(&ec->lock, flags);
> +	t = ec->curr;
>  	if (!t)
>  		goto unlock;
>  	if (t->wlen > t->wi) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
