From: reason-ss4n/k5RZhaUArH+D2fLrA@public.gmane.org (Ilya Bagrak)
Subject: Re: S3 suspend/resume driver questions
Date: Mon, 19 Apr 2004 22:47:25 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <33087.66.245.64.93.1082429245.squirrel@webmail.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: adrian-OU8u6/KFdmW45Ov3ckaPZVaTQe2KTcn/@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I can access all these functions through the "Fn" key on my keyboard, so =
I
have not experienced a real need for this patch.  Is the keyboard layout
different or are the special keys are not working on other models?  I
guess with the patch one could write a little GUI applet that can expose
these things to the user, but I find Fn keys just as easy.  Anyways I'll
let you know if the patch works for me. Thanks,

Ilya


> Ilya,
>
>> Your patch worked beautifully on my Fujitsu E7010 laptop.  Prior to
>> the patch, the system would lock up hard if I tried to load
>> snd_intel8x0 after waking up from S3.  If I didn't not unload the
>> sound modules before going to sleep, the system would not wake up at
>> all (lock up would happen on resume).  In any case, the sound "just
>> works" (tm) now.
>
> Nice to know.  From what I've seen, it looks like Fujitsu is pretty goo=
d
> with keeping things consistent between their different lines of
> notebooks.  They usually reuse components (the prism2 wifi card in your
> notebook is probably the same card as the one that's in my notebook
> [which is also used in the P2xxx series too]).  I'm guessing this patch
> I've modified would work on your notebook too (read the header of the
> patch):
>
> http://devrandom.com/fujitsu/fujitsu_acpi-2.6.patch
>
> It adds LCD brightness, volume and pointer status functionality and the
> ability to change them too.  Let me know if it works for you.
>
> Adrian
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
