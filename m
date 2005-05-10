From: Kendall Bennett <kendallb-uto6oM0aG36m1FQbPH9wZw@public.gmane.org>
Subject: Re: Reliable video POSTing on resume
Date: Tue, 10 May 2005 09:33:38 -0700
Message-ID: <4280E262.9020207@scitechsoft.com>
References: <4202DF7B.2000506@gmx.net>	 <1107485504.5727.35.camel@desktop.cunninghams>	 <9e4733910502032318460f2c0c@mail.gmail.com>	 <20050204074454.GB1086@elf.ucw.cz>	 <9e473391050204093837bc50d3@mail.gmail.com>	 <20050205093550.GC1158@elf.ucw.cz>	 <1107695583.14847.167.camel@localhost.localdomain>	 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>	 <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>	 <20050207160105.GF8040@elf.ucw.cz> <1107793204.2930.18.camel@logarithm.lanl.gov> <420C0EAF.4000606@gmx.net> <420C68B3.4080509@scitechsoft.com> <420CA2D2.6050003@gmx.net> <420D08F2.3060505@scitechsoft.com> <420D5481.1060402@gmx.net> <420D7B1B.3030503@scitechsoft.com> <421715EB.3020207@gmx.net> <42180D40.1020409@scitechsoft.com> <425907FC.6010504@gmx.net> <42807289.8090003@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42807289.8090003-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Carl,

Carl-Daniel Hailfinger said the following on 5/10/2005 1:36 AM:
> I have been unable to reach Kendall Bennett during the last few
> months. Does anyone know what happened to him?
> It would be really cool if we could POST the video card from the
> kernel and he seemed to have a solution with SNAPBoot.

I am here, but I have just been busy. We have kernel patches for the 2.4 
and 2.6 kernels that patch in VideoBoot code for ATI cards. Did you not 
get those patches? I can send them to you if you didn't get them. I 
think you can enable debug mode in the kernel version also, and the 
debug messages will go into the kernel log file.

If you still want a debug enabled version for command line I can try to 
get one together for you.

Regards,

>>Hi Kendall,
>>
>>could you please send me the debug enabled build of SNAPBoot so
>>we can find out why it's not working for me?
>>
>>Regards,
>>Carl-Daniel
>>
>>Kendall Bennett wrote:
>>
>>
>>>Sorry I have been busy. Remind me in a week as I will be out of the
>>>office all next week. When I return I should be able to send you a debug
>>>enabled version that will spit out a log file so you can find out what
>>>it is doing.
>>>
>>>on 2/19/2005 2:33 AM Carl-Daniel Hailfinger said the following:
>>>
>>>
>>>
>>>>Hi Kendall,
>>>>
>>>>Kendall Bennett schrieb:
>>>>
>>>>
>>>>
>>>>>I should send you a debug build so we can get a trace of
>>>>>what is going on.
>>>>
>>>>
>>>>
>>>>Could you do that, please? I'd like to try it out.
>>
>>
> 
> 

-- 
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
