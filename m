From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: PROBLEM: Kernel 2.6.13 up to 2.6.13.2 hangs while booting when ACPI is enabled
Date: Tue, 27 Sep 2005 09:09:38 +0200
Message-ID: <20050927070938.GB4676@message-id.gmane0305.slipkontur.de>
References: <4338230E.40309@hcsd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4338230E.40309-dKYa5QjKvtY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 26, 2005 at 06:34:22PM +0200, Stephan Austerm=FChle wrote:
> [1.] One line summary of the problem:
> Kernel 2.6.13 up to 2.6.13.2 hangs while booting when ACPI is enabled

> [8.2.] Processor information (from /proc/cpuinfo):
> Pentium-M in a HP Compaq nc8230

It looks like all newer HP compaq notebooks do only boot with "pci=3Dnoac=
pi".
We discovered this too late during SUSE 10.0 beta, at least a
nx8220 and an nc6230 do not boot/install otherwise.
There is also a SUSE bugreport for this:
  https://bugzilla.novell.com/show_bug.cgi?id=3D116763
--=20
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.=20
Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
