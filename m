From: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Fri, 23 Dec 2005 08:44:34 +0200
Message-ID: <43AB9CD2.9090106@csstirisano.co.za>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051222160633.GA3316-l3A5Bk7waGM@public.gmane.org>
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
Cc: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried wrote:
> On Thu, Dec 22, 2005 at 03:59:26PM +0200, Jaco Kroon wrote:
>>P4 - not HT though (not afaik anyway - or for a change I was blind - 
>>running without HT anyway).
> 
> it looks like you have a very different P10 than the one we have...

Similar but different yes.  Mine is P10-772 (iirc), the one mentioned in 
the kernel specs is 5??.

>>I also assume it's at this time impossible to use fglrx with resume/suspend?
> 
> ...because ours has a NVidia graphics card.

LOL!  I wish.  fglrx is the ati binary drivers (as asked in the response 
from Pavel).  According to another friend of mine the answer to this one 
is no.  He can suspend/resume his notebook as long as he's using the 
opensource radeon driver and not fglrx.  He's not using a P10 though.

>>With regards to the ACPI code though - I've managed to fix all the 
>>warnings and errors, except the one about the ResourceSource error, 
>>which according to the spec is optional but iasl insists it's required. 
>> No idea what I'm going to do about that.  Also not sure whether fixing 
>>_WAK to always return a value will actually do something.
> 
> I do not remember that i would have to fix any DSDT bugs, everything worked
> with the original DSDT.

There is only really one error that bothers me, and I read somewhere 
that the kernel doesn't look at it's value, and that is the _WAK call 
that doesn't return a value.  Unless that of course changed recently. 
And I can't recompile the DSDT due to those ResourceSource required 
errors, which seems to be a bug in iasl.

I still haven't managed to finish of the resume process.  The screen 
comes back up and console switching works but that is just about where 
it ends.  I don't see any kernel panic messages either.  Will RTFM and 
fool around some more.

> But it is some time ago that i did use this machine, and due to its 
> tremendously huge footprint and very heavy weight, i just used it
> as a Workstation, so not very frequent. Also the dual turbines did their
> share that it was turned off most of the time :-))

It's not _that_ heavy!  But yes, it is rather noisy, but nothing 
compared to these air-conditioners we have here, or my graphics card in 
my desktop at home.

>>Notice: This message and any attachments are confidential and intended 
>>solely for the addressee. If you have received this message in error, 
>>please notify the sender by email or by phone to the listed number. Any 
>>unauthorised use, alteration or dissemination is prohibited. CSS 
>>Tirisano (Pty) Ltd accepts no liability for any direct, indirect or 
>>consequential loss or damages, arising from the contents of this message.
> 
> OMG! i hope i'm not going to jail now ;-)

Company policy.  It sucks I know.  The content of these messages is 
fortunately intented for any soul who is interrested.

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
