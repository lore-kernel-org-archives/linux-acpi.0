From: Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
Subject: Re: [Discontig-devel] Cleanup of NUMA support in ACPI
Date: Wed, 7 Aug 2002 14:41:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208071441.41229.efocht@ess.nec.de>
References: <20020807033450.DALTC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020807033450.DALTC0A82650.6C9EC293-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Tak,

looks good! I'll try to fill in the arch-dependent pieces.

Only one small detail:

> --- david-020722/drivers/acpi/Config.in Tue Jul 23 16:01:28 2002
> +++ david-020722-srat/drivers/acpi/Config.in    Mon Aug  5 22:19:55 200=
2
> @@ -99,6 +99,7 @@
>      define_bool CONFIG_ACPI_FAN                n
>      define_bool CONFIG_ACPI_PROCESSOR  n
>      define_bool CONFIG_ACPI_THERMAL    n
> +    define_bool CONFIG_ACPI_NUMA       n
>      endmenu
>    fi
> =20

=46rom earlier email exchange with Jack Steiner I understood that SGI
uses at least SRAT tables. Maybe somebody from SGI can comment? So this
would have to be changed.

Regards,
Erich



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
