From: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: tg3 ethernet not coming back properly after S3 suspendon Dell M70
Date: Fri, 10 Jun 2005 13:27:09 -0700
Message-ID: <9540d0105061013275b7e7c76@mail.gmail.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502408E22FB6@orsmsx404.amr.corp.intel.com>
	 <200506101418.59154.gkanis@cems.umn.edu>
Reply-To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506101418.59154.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
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
To: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 6/10/05, Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org> wrote:
> I do not have a Dell and when I resume from suspend the monitor does not =
come
> on. I applied the patch, but it did not help. I also have a PCIE card and=
 I
> have the CONFIG_PCIEBUSPORT enabled.
> Do I need to unload the tg3 module, before I suspend the system?

I think the PCIE video suspend issues are not related to the tg3
issues, though there may still be deeper PCIE suspend issues.  I still
cannot get my video to recover, though debugging is harder because the
nvidia binary module is involved, and it seems to set the monitor's
DPMS state to "off" when it goes to suspend.  So, when the system
resumes, DPMS is still "off", and something wedges before it ever gets
put back to "on", so I can't see how far I make it in the resume
process.  (Serial console doesn't seem to be that useful.)

     - Vlad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
