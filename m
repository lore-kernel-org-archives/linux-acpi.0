From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Is this safe?
Date: 30 Jan 2003 23:30:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043987447.7313.25.camel@sirius.strandboge.cxm>
References: <200301281120.15917.jan.slezak@centrum.cz>
	 <20030129180444.GB10601@homerelay.wiesner-net.de>
	 <1043878640.1471.6.camel@sirius.strandboge.cxm>
	 <20030129230247.GB11019@homerelay.wiesner-net.de>
	 <1043883259.3421.7.camel@sirius.strandboge.cxm>
	 <20030130220318.GA12147@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SRRjgYITLHCSXCyFG8cJ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030130220318.GA12147-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-SRRjgYITLHCSXCyFG8cJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-01-30 at 17:03, Markus Wiesner wrote:
> James D Strandboge schrieb:
> > I applied Jan's patches-- I too thought they were reasonable. 
> > Everything that worked before works again here too.  But, I tried my
> > acpi_test.sh script again, and it died at iteration 16299.  Still no joy
> > on polling battery state.  I am using acpi-20021212 since it is what I
> > had lying around.  Can you lock your machine still with my acpi_test.sh?
> 
> Kernel 2.4.20, acpi-20030122, preempt-kernel and low-latency patch:
> tried it twice, both times a lockup (after 15961 and 16293) as i already
> expected.
> 

Those patches are nice-- big improvement for me. 

> But this time the system did not "really" lockup, I suppose because of
> one of the additional patches. I could use Ctrl-c to get my command
> prompt back. "top" showed "100% system" load and grep was still running
> and unkillable (not even with -9). Disregarding the high load the system
> was still usable and i could do a normal reboot instead of using
> SysRq-Key.

That is interesting.  I am not sure what it means-- I can't really
figure out if it is BIOS/dsdt, kernel or both.  Even with debugging
enabled, I don't see any errors.  I looked at the code and battery.c and
utils.c, and it seems ok.

I poked around a bit in _BST in my dsdt (the part that generates the
state), and came across method SX30.  It looks like this:

    Method (SX30, 1, NotSerialized)
    {
        Store (SXX2, Local0) 
        Increment (Local0)
        If (LNot (LGreater (Local0, SizeOf (SXX0))))
        {
            CreateByteField (SXX0, SXX2, SX20)
            Store (Arg0, SX20)
            Store (Local0, SXX2)
        }
    }

I wonder what happens when Local0 is actually bigger than SXX0?  From
this, SXX2 and SX20 stay the same, but I don't know what the
implications of that are since there are no code comments.  Also, other
methods call SX30 without problems (seemingly), and you have seen the
lockup at earlier iterations when pulling the AC.

I am starting to understand the language of the dsdt, but it is still
hard to crack.  Look at SX11-- what does it do?  It calls SXX4, which
calls SXX6, then SXX5 (which itself calls SXX6), and so on.  I
downloaded the acpi specification and started looking at it (over 500
pages).  Maybe I will get to the bottom of it.

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A


--=-SRRjgYITLHCSXCyFG8cJ
Content-Disposition: attachment; filename=dsdt-A04.dsl.gz
Content-Type: application/x-gzip; name=dsdt-A04.dsl.gz
Content-Transfer-Encoding: base64

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

--=-SRRjgYITLHCSXCyFG8cJ--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
