From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: constant processor 0x80 events
Date: Thu, 2 Jan 2003 02:58:01 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2b1bf$5782b950$1a2202d3@sayonara>
References: <20030101164052.GA31172@clara.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030101164052.GA31172-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > Your system board triggers GPE upon some hardware condition (most 
> > likely thermal in your case) and GPE handler for that event (run by 
> > OS) issues Notify 0x80 on processor object. This eventually 
> causes OS 
> > to reevaluate your _PPC object to flip the highest 
> performance state 
> > (P-State) of your processor and update the supported P-State table.
> 
> So the OS should be switching the processor to the lower 
> speedstep setting?  It isn't AFAICS.  Also it is quite 
> impossible to do so manually once this situation has 
> occurred.  I assume because the constant GPE handling is 
> holding onto a mutex which prevents its use - the downside of 
> threading this?

Actually your _PPC first evaluates 8 bits field "THRT" defined in the
"MNVS" OpRegion created in SystemMemory, which likely holds some
information about thermal condition, and if THRT is zero, we go to Else
term, ending up no P-State change. P0 stays as the highest available
P-State. 

124              Method (_PPC, 0, NotSerialized)
125              {
126                  If (THRT)
127                  {
128                      Return (One)
129                  }
130                  Else
131                  {
132                      Return (Zero)
133                  }
134              }

5258      OperationRegion (MNVS, SystemMemory, 0x1FF73E7D, 0x20)
5259      Field (MNVS, AnyAcc, Lock, Preserve)
5260      {
5261          OSYS,   16,
5262          ACON,   8,
5263          WRK0,   1,
5264          WRK1,   1,
5265          WRK2,   1,
5266          Offset (0x04),
5267          P4EN,   8,
5268          THRT,   8
5269      }

Huum, interesting. You're seeing whole bunch of Notify 0x80 on CPU0, ---
for what reason??? What makes your system to raise GPE and what is the
expected consequence? This is a sort of Hardware/BIOS design issue and
only BIOS writer can tell us everything,,, Do you have any idea?

Anyway typical usage of 0x80 I've seen is to really update P-State table
upon AC plug-in/out, and even in this case, if Notify 0x80 rushes in a
quick succession (due to chattering for example), system may misbehave. 

Please let me know your test result and if it doesn't work out, let's
look into code to figure out the best way. It could be bug in OS code
executing GPE Handler or bug in processor driver code handling 0x80
notification or what else...



 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
