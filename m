From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Generic hotkey driver for dock ejecting
Date: Sat, 27 Aug 2005 14:24:23 +0200
Message-ID: <20050827122423.GC1109@openzaurus.ucw.cz>
References: <20050826152548.GA12991@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050826152548.GA12991-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hi!

> I'm playing with a Dell Latitude D610. By doing
> 
> echo "0:\_SB.PCI0.PCIE.GDCK::\SB_PCI0.PCIE.GDCK::0:0" 
> >/proc/hotkey/event_config
> 
> I can get an event when I push the eject request button on the dock. I 
> guess the appropriate thing to do in response to this is to call the 
> dock's eject method (the dock appears to be \_SB.PCI0.PCIE.GDCK, which 
> has _EJ0, _EJ3 and _EJ4 methods). How do I go about this?
> 

Well, I guess you need to hot-unplug devices in the dock and only then
call the eject methods.

BTW it would be nice to have some common infrastructure;
I have thinkpad with dock here, too...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
