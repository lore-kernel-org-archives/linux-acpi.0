From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Suspend/resume with ATI binary driver working
Date: Thu, 16 Jun 2005 16:45:45 +0000
Message-ID: <200506161645.46116.stefandoesinger@gmx.at>
References: <200506161433.14756.stefandoesinger@gmx.at> <1118930257.12491.132.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118930257.12491.132.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> And it doesn't work unless you restore /dev/vcsa?
No, without restoring /dev/vcsa it doesn't work. I have to restore both /dev 
vcsa and the vbe state. But restoring /dev/vcsa makes restoring the vbe state 
more reliable. Sometimes(~25% of all attempts) vbestate restore brings the 
card to an unuseable state. This has never happened since I restore /dev/vcsa

Only one thing troubles me: What is /dev/vcsa???

Stefan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
