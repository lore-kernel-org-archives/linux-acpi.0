From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi enhancement request
Date: Mon, 24 Jan 2005 22:54:14 +0200
Message-ID: <pan.2005.01.24.20.54.13.198074@yahoo.com>
References: <20050124171939.14379.qmail@web50206.mail.yahoo.com> <41F5404D.5090205@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi Luca,

On Mon, 24 Jan 2005 19:37:01 +0100, Luca Capello wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hello Paul,
>=20
> on 01/24/2005 06:19 PM, Paul Ionescu wrote:
>> I am trying to write some code for ibm-acpi integration in HAL to bett=
er
>> support IBM Thinkpads in HAL.
>> (http://www.freedesktop.org/wiki/Software_2fhal )
> this is a good idea, I don't have the capacity to code and help you, bu=
t I
> can test whatever you want ;-)
>=20
>> This way we may have a general GUI for interacting with hardware, and =
we
>> can let go of tpb.
> Why don't integrate the two approaches in an unique one? The first thin=
g
> that came in my mind was this:
>    http://tpctl.sourceforge.net/configure-thinkpad.html

In the end we will have only one GUI, but that would be HAL/DBUS aware an=
d
not IBM specific.
You will be able to configure some property via a generic program, no
matter what laptop/desktop you have.

Think of something like what is alsamixer for soundcards if you like: you
can adjust parameters of various soundcards with different parameters wit=
h
only one program.





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
