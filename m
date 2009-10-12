From: Darren Salt <linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH 2.6.32-rc3] Prevent a panic when
	disabling RT2860 wireless when associated
Date: Mon, 12 Oct 2009 21:53:05 +0100
Message-ID: <50AEAEB394%linux@youmustbejoking.demon.co.uk>
References: <mpro.kr41l600vf1lc0bg3.linux@youmustbejoking.demon.co.uk>
	<71cd59b00910061418o6a9e3e65n6365972ee0980780@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <71cd59b00910061418o6a9e3e65n6365972ee0980780-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I demand that Corentin Chary may or may not have written...

> On Tue, Oct 6, 2009 at 10:43 PM, Darren Salt
> <linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org> wrote:
>> This works around what I think is actually a bug in rt2860sta which is
>> triggered when the hardware "disappears" from beneath the driver, i.e.
>> when wireless is toggled off via ACPI. It does so by ensuring that the
>> rfkill soft-block flag is set before the hardware is disabled.

>> I do not know whether this patch is required if rt2800pci is in use
>> instead of rt2860sta; at the time of submission of this patch, I've not
>> been able to test this.

>> (Ref. http://bugzilla.kernel.org/show_bug.cgi?id=13390)
[snip]
> Did you test this patch with other hardware?

All that I've been able to test with is an Intel 3945, temporarily placed in
my 901. That seems fine anyway, and the patch doesn't affect it in any way.

> Can't we fix that directly in rt2860sta ?

Probably. One of us should bisect to see exactly where this happened;
however, for me, this workaround will do until that's done or rt2800pci is
working well enough (whichever happens first). And I think that I'd prefer
the latter.

-- 
| Darren Salt            | linux at youmustbejoking | nr. Ashington, | Doon
| using Debian GNU/Linux | or ds    ,demon,co,uk    | Northumberland | Army
|   Kill all extremists!

He looked at me as if I was a side dish he hadn't ordered.

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
