From: Milan Jurik <M.Jurik-3zVPrsR01WjrBKCeMvbIDA@public.gmane.org>
Subject: IBM TP R40e ACPI known problems
Date: Sun, 10 Oct 2004 15:23:27 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0410101403500.30644@bobek.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

  here is a short known list:

  Hanging with ACPI processor module (C-state switching failure)
   - Kernel bugzilla 3219

  Not wake up from S3 state
   - maybe similar to Kernel bugzilla 3354

  Inacessible Fn+Fx keys and extra volume keys (after ACPI modules
loading), no reaction. Neither Deianov's ibm_acpi nor Rigtorp's
thinkpad_acpi helps.

  All these I know, all were reported (several times, not by me).
  I made a small webpage where all possible outputs are (acpidmp,
dmidecode etc.), it can help somebody.

  http://atari.sh.cvut.cz/acpi/links.html

  I haven't enough knowledge for ACPI hacking. But my TP is ready for all
possible patches if some ACPI developer would like to help. If any other
outputs or tests are needed, let me ask.
 Best regards,

        Milan Jurik

P.S.: It looks that also lid button doesn't generate event (but state is
changed on appropriate place - /proc/acpi/button/lid/LID/state). Can
somebody confirm it?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
