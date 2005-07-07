From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Clevo 650 Notebook: LCD not working after resume from S3
Date: Thu, 7 Jul 2005 17:58:39 +0200
Message-ID: <20050707155839.GA12706@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi there!
  I would like to ask here, because all my semi-amateur attempts to fix the
problem described below have failed.
  I have a Mironet notebook, which seems to be relabelled Clevo 650.
  I can use almost all advantages of its ACPI features, excluding one: the
"suspend to memory" (S3) feature. To be more precise, suspend itself seems
to work perfectly, but the following resume fails in a way that it doesn't
enable the LCD panel. I tried my best to find the problem and fix it, but
no success yet.
  My steps included recompiling the DSDT table after fixing one error 
(AnyAcc instead of ByteAcc) and one warning (_WAK method missing a return
value). I also tried to fake the OS name by submitting various well-known
strings to acpi_os_name. However, I cannot find any differences in the system
behaviour after all this.
  I also tried to revive the display by switching from X to console and back,
pressing the LID switch etc. Nothing helps. The rest of the system works.
  Any help will be greatly appreciated. I can send you any resources necessary
to analyze the problem (DSDT table, dmesg output etc.), I don't want to spam
the list by uneccessary junk.
  The latest kernel I've tried it is 2.6.13-rc2.
                                     With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
