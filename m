From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Integrating OS power management with the X server
Date: Mon, 25 Oct 2004 12:14:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417D509A.8040305@root.org>
References: <417D372C.3000107@root.org> <1098727986.3996.65.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098727986.3996.65.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, 2004-10-25 at 10:26 -0700, Nate Lawson wrote:
>>This interface works for apm (except that it only has NetBSD defines 
>>currently) but is not implemented for ACPI.  I'd like more information 
>>as to what the X server actually does with this event.  Is there any 
>>situation where it actually needs to veto a suspend?  Does it 
>>potentially take seconds to save state?  Does it need to access other 
>>running subsystems or is it self-contained?
> 
> At the moment, is it still the case that X will be unhappy if there are
> any DRI clients running when going through a suspend/resume cycle?

I don't know.

> If
> so, it sounds like the server ought to reject a suspend (or,
> alternatively, use the notification to kill clients).

Or better, properly implement saving state in DRI.

> In the future, I'd expect that some dbus-related system would be
> preferable - that way X doesn't get special cased, and any application
> with good cause could reject a suspend.

The existing bsd_apm.c works for NetBSD and is the same interface as APM 
in FreeBSD.  Basically, you open /dev/apm and get notification of 
suspend requests.  Then you can continue them by sending a suspend ioctl 
or veto by just ignoring them.  The problem is, there are some times in 
ACPI when the userland cannot veto a suspend (i.e., critical battery or 
system temperature).  My plan is to initiate an unconditional suspend in 
those cases from the kernel.  Userland will have a chance to get the 
notification but if it doesn't respond within some timeout (say a few 
seconds), the kernel continues the suspend process.

The reason for my email is it's not clear what semantics X expects and 
how much it even uses this interface.

-- 
Nate


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
