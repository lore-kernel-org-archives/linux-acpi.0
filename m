From: <pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
Subject: problem with suspension
Date: Wed, 16 Feb 2005 20:14:36 +0100
Message-ID: <web-47803451@infinito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Hi,
    I have a problem with suspension.
When I do

  echo disk > /sys/power/state

I have a problem with modules of SCSI controller, aic7xxx.
I've tryed to remove the modules with

   modprobe -r aic7xxx

but the kernel was in panic. The message is

   Kernel Panic - Not syncing: Loop 1

If I don't load the module aic7xxx and I try to do the=20
suspension, all is ok.

What I do?

Sorry for my english.
Tnk
Luca
_______________________________________
Connessione ed e-mail gratuita da 10 mb
consultabile tramite web e tramite pop.
www.infinito.it vieni a scoprire tutti=20
i nostri servizi!

http://www.infinito.it/xmail



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
