From: Dino Klein <zagzag-lists-zY4eFNvK5D9If6P1QZMOBw@public.gmane.org>
Subject: Re: Centrino question
Date: Sun, 09 May 2004 13:51:13 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <409E6F91.8090506@speakeasy.net>
References: <20040509182524.03a9de0d.neurowork@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040509182524.03a9de0d.neurowork-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have an Acer C302, with a Pentium M 1.6, and the Intel 855GME chipset. 
The CPU/chipset supports C1 - C4.
My hypothesis as to why you don't have C3 is because it is disabled thru 
the value of the C3 latency in the FADT. The DSDT code probably has a 
_CST field/method for the processor, which specifies the available 
C-States. I've used a patch (from here 
http://bugzilla.kernel.org/show_bug.cgi?id=1958), that reads the _CST 
object.
Give it a try, and see if it solves your issue.


Cyril Wattebled wrote:
> Hi there,
> 
> I'm wondering if all Pentium M processor support C1 C2 and C3 ?
> Because I have a Sony Vaio Z1 with a Pentium M 1.7ghz and linux only detects C1
> and C2. I have a friend who has a Toshiba Tecra with a Pentium M 1.4ghz and it
> supports C3.
> I have heard that even C3 and C4 are supported by Centrinos.
> I'm using kernel 2.6.6-rc3. 
> Is there a logical answer why the kernel does only detect C1 and C3 ?
> Thanks
> 
> Cyril


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
