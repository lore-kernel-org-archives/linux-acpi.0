From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: Re: [PATCH 6/8] eeepc-laptop: Prevent a panic when disabling RT2860  wireless when associated
Date: Thu, 15 Oct 2009 19:41:56 +0100
Message-ID: <50B02E33C0%linux@youmustbejoking.demon.co.uk>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
 <1255582783-16088-1-git-send-email-lenb@kernel.org>
 <b56ab33d68638e6aafdbfc694025e8354a628f49.1255582742.git.len.brown@intel.com>
 <71cd59b00910150205o1c17d7aase0167848e1360659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:43493 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935377AbZJOTrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Oct 2009 15:47:36 -0400
In-Reply-To: <71cd59b00910150205o1c17d7aase0167848e1360659@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

I demand that Corentin Chary may or may not have written...

> On Thu, Oct 15, 2009 at 4:59 AM, Len Brown <lenb@kernel.org> wrote:
>> From: Darren Salt <linux@youmustbejoking.demon.co.uk>
>>
>> This works around what I think is actually a bug in rt2860sta which =
is
>> triggered when the hardware "disappears" from beneath the driver, i.=
e.
>> when wireless is toggled off via ACPI. It does so by ensuring that t=
he
>> rfkill soft-block flag is set before the hardware is disabled.
[snip patch]

> I sent you a revert request 2 days ago for this patch, Darren reporte=
d
> some problems with it.
> You may have missed it, it can be found at:
> http://marc.info/?l=3Dlinux-acpi&m=3D125542258501548&w=3D2 .
> Is it still time to revert?

I certainly hope that there's still time =E2=80=93 a much better patch =
for this
(which fixes the problem directly in rt2860sta) arrived in Greg KH's
staging.current queue late yesterday.

--=20
| Darren Salt            | linux at youmustbejoking | nr. Ashington, | =
Doon
| using Debian GNU/Linux | or ds    ,demon,co,uk    | Northumberland | =
Army
|   Let's keep the pound sterling

Established technology tends to persist in spite of new technology.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
