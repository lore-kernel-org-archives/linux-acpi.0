From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 6 Sep 2005 14:38:53 +0800
Message-ID: <200509061438.53907.luming.yu@intel.com>
References: <41E81C2C.8010809@bartol.udel.edu> <41EF1F6A.5000807@bartol.udel.edu> <75eeb70e05090520257be89afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <75eeb70e05090520257be89afa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, frikimaster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 06 September 2005 11:25, Antoni Villalonga wrote:
> 2005/1/20, Rich Townsend :
> > Tonight's build:
> >
> > http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050120.tar.gz
>
> I'm sorry for reply an old mail.
> But, it's the last release of acpi_sbs kernel module?
>
> I know about sbs-linux project in sourceforge, but I get a big delay
> (about ~20 seconds) with my Acer TM 4001 when I try to read battery
> status.
Please try this patch:
http://bugzilla.kernel.org/show_bug.cgi?id=3851#c73


>
> There are any way to fix it?
>
> Thanks!!
>
> (Sorry my English, I'm not an English speaker)


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
