From: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>
Subject: Re: Compilation error acpi-20020725-2.4.18
Date: Fri, 26 Jul 2002 10:11:19 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0207261010250.681-100000@crak.roomfullaspies.com>
References: <20020726141906.3578.qmail@gonicus.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020726141906.3578.qmail-t5zJAXK//yKELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Birger Peer =?iso-8859-15?q?K=FCpper?= <kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just removed all references to that 'name' field to make it compile.  It
seems to work once you do that.


-mathias


On Fri, 26 Jul 2002, Birger Peer [iso-8859-15] K=FCpper wrote:

> Hello,
> I`ve patched a 2.4.18 vanilla Kernel with the acpi-20020725-2.4.18.diff P=
atch.
>=20
> During compilation I got some errors like:



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
