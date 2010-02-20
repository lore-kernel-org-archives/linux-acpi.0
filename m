From: Ansgar Burchardt <ansgar@43-1.org>
Subject: Re: Debian on the ASUS EeePC 1005PE
Date: Sat, 20 Feb 2010 14:18:11 +0900
Message-ID: <87fx4wscx8.fsf@marvin.43-1.org>
References: <87y6iqy58p.fsf@marvin.43-1.org>
	<9b2b86521002190810if166725ob21c005f250bf152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <debian-eeepc-devel-bounces+gldde-debian-eeepc-devel=m.gmane.org@lists.alioth.debian.org>
In-Reply-To: <9b2b86521002190810if166725ob21c005f250bf152@mail.gmail.com>
	(Alan Jenkins's message of "Fri, 19 Feb 2010 16:10:39 +0000")
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/options/debian-eeepc-devel>,
	<mailto:debian-eeepc-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/debian-eeepc-devel>
List-Post: <mailto:debian-eeepc-devel@lists.alioth.debian.org>
List-Help: <mailto:debian-eeepc-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/debian-eeepc-devel>,
	<mailto:debian-eeepc-devel-request@lists.alioth.debian.org?subject=subscribe>
Sender: debian-eeepc-devel-bounces+gldde-debian-eeepc-devel=m.gmane.org@lists.alioth.debian.org
Errors-To: debian-eeepc-devel-bounces+gldde-debian-eeepc-devel=m.gmane.org@lists.alioth.debian.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, debian-eeepc-devel@lists.alioth.debian.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Alan Jenkins <sourcejedi.lkml@googlemail.com> writes:
>> I got an ASUS EeePC 1005PE a few days ago and am trying to install
>> Debian testing on it.
> <snip>
>> 2. The Ethernet card disappeared completely.  It did no longer show up
>> in the output from lspci, nor was it accessible in Windows.  This
>> problem persisted over shutdowns as well.  Removing the battery and
>> disconnecting the power supply luckily made the card show up again.
>>
>> A patch was available for this issue on a different EeePC model [3].
>> This one was not so easy to backport, so I just changed it to disable
>> hot-plug always (patch attached).  This solved this issue for me: the
>> Ethernet card does no longer disappear.
>>
>> [3] http://bugzilla.kernel.org/show_bug.cgi?id=14570
>
> My suggestion for this problem would be to contact the eeepc-laptop
> maintainer :-).
>
> I guess we're too late to add a blacklist entry for 2.6.33, but we
> should be able to get a fix into 2.6.33.1.
>
> Please confirm that the wireless toggle key (possibly fn+f2) works
> correctly for you after disabling hotplug.  That is, it doesn't break
> if you disable the wireless and enable it again (and you don't see
> anything too scary in the kernel log).

After finally managing to set up hostapd, I can confirm that this works.
I disabled the wireless interface using [Fn]+[F2], then enabled it
again.  After restarting hostapd, I was able to connect to use the
wireless network again.

The kernel log contains nothing scary (only a boring "wlan0: no IPv6
routers present").

Regards,
Ansgar
