From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode
	the default
Date: Sun, 15 Jul 2007 22:19:53 +0100
Message-ID: <20070715211953.GA6527@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223341511-git-send-email-hmh@hmh.eng.br>
	<20070714223315.GB25782@srcf.ucam.org>
	<20070715180529.GF14134@khazad-dum.debian.net>
	<20070715183823.GC3235@srcf.ucam.org>
	<20070715200948.GC19066@khazad-dum.debian.net>
	<20070715201346.GB5518@srcf.ucam.org>
	<20070715211421.GG19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715211421.GG19066-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 06:14:21PM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > We already have in-kernel drivers that do this properly, so I'd suspect 
> > that whoever told you that was wrong.
> 
> I got tired of being told one way or the other, already.
> 
> My position is simple, for now: I am keeping model-specific knowledge on the
> driver to the bare minimum needed for correct driver operation.  But I will
> add it anytime I fell it is needed to keep correct driver operation.

Right now, the hotkey functionality of the driver is not terribly useful 
without (bleeding-edge) userspace. This is inconsistent with the 
majority of input drivers which do something broadly sane in that 
situation.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
