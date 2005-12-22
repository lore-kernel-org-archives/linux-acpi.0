From: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 16:28:13 +0200
Message-ID: <43AAB7FD.3000901@csstirisano.co.za>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <20051222141500.GA15412@g16.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051222141500.GA15412-+Mg20aWpcBQb1SvskN2V4Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Cc: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Holger Macht wrote:
> Tested with 2.6.14 kernels without hyperthreading and both suspend to disk
> and suspend to ram are working when using acpi_sleep=s3_bios,s3_mode at
> the boot prompt. Though, with smp kernels and hyperthreading enabled, both
> are not working (video.txt already contains this information).
> 
> Regards,
>         Holger

Indeed.  Although - the keyboard does not come back properly or 
something broke along the way.  I can switch between VTs but I can't 
input into any of the ttys.

Will experiment more this evening, on my way home now.  Thanks for 
pointing me to the right docs (those I should have RTFMed in the first 
place).

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
