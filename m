From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 14:02:57 +0200
Message-ID: <pan.2005.01.21.12.02.56.759636@yahoo.com>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com> <1106265797.30227.3.camel@tyrosine>
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

On Fri, 21 Jan 2005 00:03:17 +0000, Matthew Garrett wrote:

> hal is probably the right layer to do this, rather than develop yet
> another niche abstraction library. I believe the fd.o people are workin=
g
> on it.

HAL is the right layer, and they are already working on ACPI, APM and
maybe other interfaces.
But a documentation would be nice for them too.
They should focus on implementing things in HAL instead of digging in the
kernel to see what to expect in various scenarios.

Thx,
Paul





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
