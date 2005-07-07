From: Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Subject: S3 power drain on Thinkpad R32 (fixed?)
Date: Wed, 06 Jul 2005 20:50:31 -0400
Message-ID: <42CC7C57.5060609@netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

So I had essentially been told that the improving the power drain due to 
the video subsystem during suspend to RAM was a hopeless case (it's a 
Radeon mobility M6 system).

However, I noticed some interesting comments in the radeonfb module and 
tried installing it and noticed that it improved battery life 
dramatically and doesn't need any video_post nonsense. It even seems to 
play OK with X, which is great.

I spoke to BenH who said that there may be recent ACPI fixes that 
address this issue outside of radeonfb.  Does anyone know about this? 
That would be nice, since I don't quite trust radeon and radeonfb to be 
reliable together.

The kernel version is apatched 2.6.12-1.1387_FC4 with some minor tweaks 
and a patch that's supposed to make radeon and radeonfb work better 
together.



-- 
Yes, but will it wash my dishes?
Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
