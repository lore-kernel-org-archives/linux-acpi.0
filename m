From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: RE: generic ACPI video and hotkey drivers vs.
	platform-specificdrivers
Date: Wed, 18 May 2005 17:51:39 +0100
Message-ID: <1116435099.10344.58.camel@tyrosine>
References: <3ACA40606221794F80A5670F0AF15F84041AC149@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC149@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-03-06 at 22:02 +0800, Yu, Luming wrote:
> Please take a look at the prototype filed at http://bugzilla.kernel.org/show_bug.cgi?id=3887 
> The basic idea is to supply interfaces to configure generic hotkey driver to make it work on any specific platform that requires the execution of some specific AML methods.

I've tried playing with this (why does it disable the existing drivers
all the time, rather than just when it's loaded?), but the documentation
seems to be lacking - I haven't figured out how to drive it at all. It'd
be really helpful to have a set of sample configurations to mimic the
behaviour of existing drivers.

I'm also not entirely clear on how userspace is meant to interface with
this. Am I right in thinking that it's something like the following:

a) register hotkey event
b) this causes event in /proc/acpi/event
c) userspace picks up on that and then triggers an acpi method that's
been registered beforehand

?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
