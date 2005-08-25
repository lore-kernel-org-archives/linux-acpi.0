From: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Thu, 25 Aug 2005 19:32:16 +0200
Message-ID: <20050825173216.GB4055@inferi.kami.home>
References: <6694B22B6436BC43B429958787E454983CBD0C@mssmsx402nb> <2fc0cdd205082503364f255347@mail.gmail.com> <20050825172227.GA4055@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050825172227.GA4055-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2005 at 07:22:28PM +0200, Mattia Dongili wrote:
> On Thu, Aug 25, 2005 at 12:36:52PM +0200, Mattia Dongili wrote:
> > On 8/25/05, Starikovskiy, Alexey Y <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
[...]
> I'll restore the WARN_ON(*owner_id!=0) in acpi_ut_allocate_owner_id and
> see if I can get more out of it.
[...]
> Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:70
>  [<c02170c1>] acpi_ut_allocate_owner_id+0x3d/0xdb
>  [<c01f64ae>] acpi_ds_call_control_method+0xed/0x303
>  [<c020e471>] acpi_ps_parse_aml+0xf1/0x2d0
>  [<c020e485>] acpi_ps_parse_aml+0x105/0x2d0

doh... the mentioned WARN_ON was already there and was the author of that
stack dump

>  [<c0228673>] acpi_thermal_get_temperature+0x63/0xdb
>  [<c02298cb>] acpi_thermal_temp_seq_show+0x30/0x8d

and polling the thermal_zone was actually what issued it...

-- 
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
