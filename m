From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Asus K8V Delux broken acpi tables?
Date: Tue, 11 Oct 2005 09:32:40 +0200
Message-ID: <434B6A98.6000706@suse.de>
References: <43475CDB.6070204@cfl.rr.com> <4347ED97.1090504@cfl.rr.com> <434A3BB4.1050404@suse.de> <434B171A.3040103@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <434B171A.3040103-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Phillip Susi wrote:
> I think I updated my bios a month or two ago.  I'm not quite sure how to 
> recompile my DSDT.  I thought I needed to use iasl to decompile the 
> existing DSDT from acpidump, then apply your patch, then recompile.  I 
> seem to be missing something though, iasl -d doesn't seem to like my 
> acpidump.log.
> Also getting iasl compiled was kind of a pain, the code is a bit 
> borked.  First I had to add the -l flag to flex so that unput() could be 
> used correctly, then the code was declaring a variable in one place as a 
> char [] and in another as a char *, so I had to fix that to get it to 
> compile.  Even then it had a bunch of warnings because of incorrect 
> casts due to assumptions about being on a 32bit architecture ( I'm 
> running 64 bit ).

I used ACPICA 20050902 compiler.
Hopefully there is nothing broken in newer versions?
I will give it a try if I find the time ...
I will send you the compiled versions privately.

       Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
