From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [ACPI] Re: since 2.6.9 reboots instead of poweroff (solved)
Date: Tue, 23 Nov 2004 11:32:36 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305759993D0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <softwaresuspend-help-admin@lists.berlios.de>
Content-class: urn:content-classes:message
Sender: softwaresuspend-help-admin@berlios.de
Errors-To: softwaresuspend-help-admin@berlios.de
List-Help: <mailto:softwaresuspend-help-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-help@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-help>,
	<mailto:softwaresuspend-help-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-help>,
	<mailto:softwaresuspend-help-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-help/>
To: Bernard Blackham <bernard@blackham.com.au>, Akos Maroy <darkeye@tyrell.hu>
Cc: Sebastian Kr?mer <spambouncer@skraemer.de>, softwaresuspend-help@lists.berlios.de, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

It has been fixed there:
http://bugme.osdl.org/show_bug.cgi?id=3669

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
>admin@lists.sourceforge.net] On Behalf Of Bernard Blackham
>Sent: Monday, November 22, 2004 11:56 PM
>To: Akos Maroy
>Cc: Sebastian Kr?mer; softwaresuspend-help@lists.berlios.de; acpi-
>devel@lists.sourceforge.net
>Subject: [ACPI] Re: [SoftwareSuspend-help] since 2.6.9 reboots instead
of
>poweroff (solved)
>
>On Sun, Nov 21, 2004 at 11:18:39AM +0100, Akos Maroy wrote:
>> Bernard Blackham wrote:
>> I commented the above out, and rebooted with that kernel, but the
effect
>> is the same - it reboots instead of powering off :(
>
>Gah. What I said didn't actually make any sense - that code never
>even gets called on shutdown.
>
>Here is a workaround that works for me. It's not the correct the
>solution, but probably suffices unless you want wakeup events which
>are not the power button :)
>
>Bernard.
>
>--
> Bernard Blackham <bernard at blackham dot com dot au>
