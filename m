From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: constant processor 0x80 events
Date: Thu, 2 Jan 2003 10:15:13 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030102101513.GA947@clara.net>
References: <20030101164052.GA31172@clara.net> <000001c2b1bf$5782b950$1a2202d3@sayonara> <20030101192644.GA31476@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030101192644.GA31476-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Faye Pearson [faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org] wrote:
(but forgot to cc to the list)

> Adachi, Kenichi [aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org] wrote:
> > Actually your _PPC first evaluates 8 bits field "THRT" defined in the
> > "MNVS" OpRegion created in SystemMemory, which likely holds some
> > information about thermal condition, and if THRT is zero, we go to Else
> > term, ending up no P-State change. P0 stays as the highest available
> > P-State. 
> 
> THRT = Throttle?  Anyway, nothing in the DSDT updates that field.  Is
> the OS supposed to?  Perhaps that is what the OS is supposed to assert
> when it receives this message?  I hate groping in the dark :/

I've used THRT as the one shot flag in the meantime and I'll see how it
goes.

> > Huum, interesting. You're seeing whole bunch of Notify 0x80 on CPU0, ---
> > for what reason??? What makes your system to raise GPE and what is the
> > expected consequence? This is a sort of Hardware/BIOS design issue and
> > only BIOS writer can tell us everything,,, Do you have any idea?
> 
> The only time I've seen this is when the processor has been running at
> full pelt for some time - ie the CPU temp is high.  I would say that the
> processor is just trying to tell the OS to switch the processor state
> down 'cause it's hot.  Probably in the wrong way :)
> 
> I would say it's probably wrong to flood the system with these events.
> 
> Is the event being sent as quickly as it can be received?  If so then
> the action associated with the event should be run from the same thread
> or it will never be actioned.
> 
> > Anyway typical usage of 0x80 I've seen is to really update P-State table
> > upon AC plug-in/out, and even in this case, if Notify 0x80 rushes in a
> > quick succession (due to chattering for example), system may misbehave. 
> 
> Perhaps it should be a one shot, reset when the processor state changes?
> eg. in _L00
> 
> If (LNot(THRT)) {
>   Store (One, THRT)
>   Notify (\_PR.CPU0, 0x80)
> }
> 
> and in _PPC
> 
> If (THRT) {
>   Store (Zero, THRT)
>   Return (One)
> }

This is what I'm currently running with.  The thing is I'm not sure
whether that will cause any other side effects - any ideas?

> > Please let me know your test result and if it doesn't work out, let's
> > look into code to figure out the best way. It could be bug in OS code
> > executing GPE Handler or bug in processor driver code handling 0x80
> > notification or what else...
> 
> Well, it does prevent the rush of messages but I don't think that's an
> elegant solution.  How do other laptops report overheat request for
> Pstate change?



-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Eschew obfuscation.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
