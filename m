From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.4.x ACPI updates
Date: Mon, 18 Aug 2003 17:08:52 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F414064.4080405@pobox.com>
References: <F760B14C9561B941B89469F59BA3A8470255EEDA@orsmsx401.jf.intel.com> <3F413F38.1030104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F413F38.1030104-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: eric.valette-GANU6spQydw@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Eric Valette wrote:
> I was patiently waiting for sourceforge ACPI page to be updated but as 
> it does not happen (Andrew?) I tried your patch and found one problem 
> with it and one with the patch itself :

Well, Intel's patch, not mine :)


> 1) The patch does not apply correctly for driver/acpi/Config.in. As It 
> is a single block to replace, I copied the new block by hand but then 
> xconfig started to fail. I just reverted to original version.

It definitely applies to 2.4.22-rc2 here...  weird.


> 2) I own a A7V that has been blacklisted by last patch while I have been 
> using ACPI (mainly for software power off via power button on this 
> machine :-)). Using ht only, I lost silently this feature and halted my 
> machine without any form of sync which is rather bad... Seeing the 
> message concerning blacklisted machine, I tried with acpi=force at boot 
> time and of course booted sucessfully. Here is the dmesg attached. May I 
> have a few words about the reason why this machine has been blacklisted?

I'll let the ACPI guys take this one...

	Jeff








-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
