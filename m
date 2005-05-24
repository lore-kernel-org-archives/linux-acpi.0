From: Luming Yu <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: problem with suspension
Date: Tue, 24 May 2005 22:50:53 +0800
Message-ID: <3877989d0505240750749c0125@mail.gmail.com>
References: <web-47615334@infinito.it>
Reply-To: Luming Yu <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <web-47615334-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
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
To: "pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org" <pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please send to acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
Please don't post message large than 80k.

Thanks,
Luming

On 2/16/05, pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org <pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org> wrote:
> Hi,
>    I have a problem with suspension.
> When I do
>=20
>  echo disk > /sys/power/state
>=20
> I have a problem with modules of SCSI controller, aic7xxx.
> I've tryed to remove the modules with
>=20
>   modprobe -r aic7xxx
>=20
> but the kernel was in panic. The message is
>=20
>   Kernel Panic - Not syncing: Loop 1
>=20
> If I don't load the module aic7xxx and I try to do the
> suspension, all is ok.
>=20
> What I do?
>=20
> Sorry for my english.
> Tnk
> Luca
> _______________________________________
> Connessione ed e-mail gratuita da 10 mb
> consultabile tramite web e tramite pop.
> www.infinito.it vieni a scoprire tutti
> i nostri servizi!
>=20
> http://www.infinito.it/xmail
>=20
>=20
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
