From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: acpi-20040715+D600+Suspend
Date: Wed, 01 Sep 2004 12:02:49 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094011369.16188.42.camel@neuromancer.home.net>
References: <B44D37711ED29844BEA67908EAF36F03B0D792@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03B0D792-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-09-01 at 11:12, Li, Shaohua wrote:
> On Wednesday, September 01, 2004, Nathan Bryant wrote:
> >>
> >>
> >I was afraid you were going to say that.
> >
> >You know there is already some special case code to init the i8259
> >earlier for specfic blacklisted laptops. Maybe we can generalize that;
> >it is starting to look like we are stuck with special casing all the
> IRQ
> >init. Do you agree or disagree?
> Don't know if it can apply for all cases. IIRC, there is a similar case
> (in SMP, resume MTRR) about resume failure in IRQ disabled. Pavel, can
> you show us a light per the MTRR case?

Okay.. this is too deep for me to understand.
The latest resume from hibernate ended up with a segmentation fault and
placed me in a virtual term and it says INIT ??? I didn't copy it down
since I didn't have a pen/paper handy. (it says it's retrying at every
30sec interval)

I just tried booting up with the normal kernel boot parameter "vga=0x342
resume=/dev/hdx", the resume still has the same thing.

Let me know how I can help.

The Keyboard press to get it to start writing to the swap, is it
relevent?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
