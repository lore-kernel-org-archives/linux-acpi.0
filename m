From: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Subject: AC adapter status wrong after resume (swsusp, pmdsik)
Date: Mon, 22 Mar 2004 16:46:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040322154654.GA10305@pern.dea.icai.upco.es>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear sirs,

      Iam an user of linux 2.6.x on a Vaio FX701 laptop. I found a little
      problem with AC charger status and the suspend/resume software, and so
      I copy this message to your list, after a kernel developer suggested
      me to do so. 

      I am not subscribed to this list, not yet... 

      Thank you  in advance,
                   Romano Giannetti


      
>    	I think I found a problem with ACPI and disk-suspend "swsusp" option
>         of 2.6.4 kernel. 
>         
>         In a few words: when resuming the "ac adapter status" would not
>         refresh: if I suspend the laptop with the AC adapter on, then on
>         resuming ACPI -v will report AC on even if I have plugged out the
>         charger. Plugging the charger in and out will resume normal
>         behaviour. I discovered it because cpufreqd would not lower the CPU
>         clock after the resume... 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
