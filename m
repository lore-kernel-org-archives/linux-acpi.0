From: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 15:59:26 +0200
Message-ID: <43AAB13E.4080206@csstirisano.co.za>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051222120413.GA28743-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Cc: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried wrote:
> On Thu, Dec 22, 2005 at 12:02:19PM +0100, Pavel Machek wrote:
>>>I'm having some trouble with suspend/resume on my Toshiba Satellite P10 
>>>and was wondering whether anybody would be able to assist.
>>>
>>>The omnibook module makes some functionality (like the multimedia keys, 
>>>temperature readings, LCD and FAN adjustments) available.  It however 
>>>does not help with suspend/resume at all.
>>>
>>>It seems like the notebook only supports standby and suspend to ram.  It 
>>>seems to come out of standby almost immediately and never come out of 
>>>suspend to ram.  Running hibernate-ram -n works fine, but when running 
>>>it without -n it actually suspends to RAM, hdd spins down, network goes 
>>>down, CPU fans stop and the power led turns red (instead of the normal 
>>>blue - this is in accordance with what I've seen with Windows).
>>>
>>>When it's time again to resume however, it just does nothing and I need 
>>>to power-cycle the machine to get it usable again.
>>
>>P10... is it that beast with pentium4 and hyperthreading? Dual cpu
>>fans?

P4 - not HT though (not afaik anyway - or for a change I was blind - 
running without HT anyway).

>>That worked for me. See Doc*/power/video.txt. Yep, that one works with
>>right config. Get swsusp working, first. Then you can debug s2ram.

Ah.  I missed those options.  Those might well solve a few things. 
Can't reboot atm (At the work and processor is working overtime at the 
moment).  Also, they mention fesafb - will switch that off for the while 
being just to first get the basic stuff working, then try to re-add 
that.  Don't know whether that will be possible.

I also assume it's at this time impossible to use fglrx with resume/suspend?

> Holger, do you have any hints on recent kernels on the P10? I have not
> touched this beast (the right noun for this brick :-) for a long time.

"The beast" specs and what I've done (and gotten working) so far is 
available at http://www.kroon.co.za/howto.php?howto=toshiba_p10.

I do recall that booting with acpi=off caused the notebook to die in a 
similar fashion on reboot.  Not sure what the cause is/was but it's 
working mostly now.  Could be the same thing that causes both hangs.

With regards to the ACPI code though - I've managed to fix all the 
warnings and errors, except the one about the ResourceSource error, 
which according to the spec is optional but iasl insists it's required. 
  No idea what I'm going to do about that.  Also not sure whether fixing 
_WAK to always return a value will actually do something.

Thanks,

-- 
Jaco Kroon
Support Engineer
CSS TIRISANO
Computer Systems (Pty) Ltd
Tel:   +27 12 621 3171
Fax:   +27 12 661 4984
Cell:  +27 84 515 8255

Notice: This message and any attachments are confidential and intended 
solely for the addressee. If you have received this message in error, 
please notify the sender by email or by phone to the listed number. Any 
unauthorised use, alteration or dissemination is prohibited. CSS 
Tirisano (Pty) Ltd accepts no liability for any direct, indirect or 
consequential loss or damages, arising from the contents of this message.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
