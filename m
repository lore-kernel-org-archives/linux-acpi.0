From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: Building the latest acpica on debian
Date: Sun, 23 Oct 2005 16:33:25 +0200
Message-ID: <20051023143325.GD5314@inferi.kami.home>
References: <435B96DA.8040602@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <435B96DA.8040602-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Cc: ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 23, 2005 at 03:57:46PM +0200, Berthold Cogel wrote:
> Hello!
> 
> I'm trying to build the latest acpica package (acpica-unix-20050930) on
> my debian system using flex-old (flex version 2.5.4). I'm getting some
> warnings and I wonder if I have to be worried about them. I've attached
> the output of make. I've compiled iasl with gcc-3.3, gcc-3.4 and gcc-4.
> Especially the bison (bison (GNU Bison) 1.875d) warnings don't look
> good. Do I have to be aware of any problems if I use the compiled iasl?

Well, I'm not aware of any at the moment. If you find any feel free to
report them.

BTW: I uploaded the acpica-unix package in Debian's NEW queue some days
ago, the iasl package will hopefully be available soon

-- 
mattia
:wq!


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
