From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Radeon Resuming from S3: Try 2
Date: Wed, 1 Dec 2004 20:33:05 -0500
Message-ID: <200412012033.05893.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Given the recent positive developments and success stories concerning resuming 
ATI hardware from S3 suspend, I thought I'd give suspending my desktop PC to 
S3. Briefly, relevant parts of my hardware:

- ATI Radeon 7000
- Intel AGP chipset
- Linux kernel 2.6.9, ACPI 20041105

I want to be able to use framebuffer (vesafb, for bootsplash). DRI is 
certainly not required. It appears I have two options: the s3_late_bios patch 
or dummydriver/resume-finish-split. What do I need to do to try each one? For 
example, I know I need to pass acpi_sleep=s3_late_bios to my kernel to use 
that patch. It's unclear to me what I need to do with the dummydriver or 
resume-finish-split patches. Can someone tell me what I need to do? I don't 
really need step-by-step instructions, just need to know what to do.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
