From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Wed, 30 Jun 2004 22:16:31 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsaeu9tyb4evsfm@smtp.pacific.net.th>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <opsadhbojo4evsfm@smtp.pacific.net.th> <20040629221111.GB25464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040629221111.GB25464-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: keld-6PR53cSIHaE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 30 Jun 2004 00:11:11 +0200, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
>
>> >>Many times I just want to read the screen, eg emails or documents,
>> >>and then still the cpu will be in idle mode, where
>> >>it uses 7.5 W out of the about 15 W that the whole machine uses.
>> >>I have found out from Intel data sheets that my
>> >>Mobile Intel Celeron 2.0 GHz CPU consumes 7.5 W in idle loop/
>> >>stop grant/sleep states, (and 5.0 W i deep sleep state).
>> >>
>> >>So I would like to have the CPU stopped completely (consuming 0 W)
>> >>while I still could read the screen. In that way I should
>> >>be able to have about double the lifetime on the battery,
>> >>going to about 7 hours from the 3.5 hours I have now.
>> >>
>> >>I would like the machine to wake up again by any keystroke
>> >>on the keyboard or mouse input. I would like the input to be
>> >>reacted upon (not just used to wake up the system, and
>> >>then forgotten).
>> >>
>> >
>> >S1 is what you want... but... if you get what you asked for,
>> >do you realize that for example clock would not update on the desktop
>> >in this mode?
>>
>> Which hardware can power down the CPU on its own?
>
> I thought that CPU powered down is pretty much definition S1.
>

Please refer to http://acpi.sourceforge.net/documentation/sleep.html
and ACPI spec 2.0a around Page 216

"Sleep States
	S1 - "Stopgrant"
	Power to cpu is maintained, but no instructions are executed.
	The CPU halts itself and may shut down many of its internal
	 components. In Microsoft Windows, the "Standby" command
	is associated with this state by default.
"

If you look at the original post, S1 "Stopgrant" costs 5W on his celeron.=
 It takes a lot
more on many 90nm chips. I read in the Centrino datasheet that it can dra=
w 15W
stopgrant at  _maximum_ vcore!!!. The maximum  possible power consumption=
 is only 25W!.
Now, that is life with modern CMOS, leakage is most of the power consumpt=
ion....
I think it will improve but 1:3 is the best you can expect for multi GHZ =
CPU's.

The transmeta i am  typing takes only 0.5W in Stopgrant but is performace=
 is much less at
"full power" of 5W/600MHz. Its standby to full power ration is 1:10, vs 2=
:3 for P4EE's...

So again, which (mainboard/notebook) HW does depower the CPU and keeps th=
e rest running ?

As to ACPI there should be a S2.5 state, or a S3 extension to power down =
the CPU and run the rest...

So, I stick to the validity of my original post :)

	Michael






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
