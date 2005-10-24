From: Thom Cherryhomes <thom.cherryhomes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: sony vaio pcg-k45 hell
Date: Sun, 23 Oct 2005 19:07:08 -0600
Message-ID: <64b848100510231807u36cd8056q521204eaa9099ebc@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

well, to start:

(1) battery meter most of the time shows zero
(2) I get maybe 1 hour battery time.
(3) S3 suspend does NOT work at all (using hibernate-ram script)
(4) i get unusual time readings that seem to keep incrementing when
the battery is charging (when I DO see the battery meter)
(5) no fan control
(6) display does not dim when disconnected.
(7) hotkeys for changing brightness etc do not work.

arrggghhhhh

I tried to find a PSS table in the DSDT, and couldn't.. it seems the
acpi on this laptop is insanely broken. :-(

-Thom

On 10/22/05, Yu, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Please describe the issues you have.
> Fixing in DSDT is not a decent way.
>
> Thanks
> Luming
>
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
> >Thom Cherryhomes
> >Sent: 2005年10月23日 8:54
> >To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: [ACPI] sony vaio pcg-k45 hell
> >
> >I am having some interesting issues with the Sony VAIO PCG-K45, and I
> >need some help decoding the DSDT, to see what I need to fix etc..
> >perhaps some help on fixing it...
> >
> >I have a disassembly of the DSDT here
> >http://64.74.186.169/pcgk45.dsl.txt
> >
> >can someone perhaps shed some light on what could be wrong here?
> >
> >-Thom
> >
>


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
