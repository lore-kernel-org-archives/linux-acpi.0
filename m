From: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Subject: Re: Compaq 1700, 2.4.18, acpi-7,24 - SUCCESS (I think)
Date: Wed, 14 Aug 2002 20:18:23 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0208142004370.16304-100000@sediment.umd.edu>
References: <15706.48376.457358.298696@chaos.crhc.uiuc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <15706.48376.457358.298696-+pt9qS7RU9EeNw9RxQLXc5Vzexx5G7lz@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi list,

Graham, nice to see that I am not all alone :) I too have the same status
with the acpi-20020726 patch on a similar model (mine is 1720US).

However, my kernel just keeps repeating "schedule_task(): kevent has not
started" after the alleged two "PCI Interrupt Link enabled" statements. It
never freezes.


Just before these statements I used to get an error:

"pci_bind_0191[22] acpi_pci_bind device 00:00:1d.02 not present in PCI
namespace".

Hawkins, pointed out that my DSDT had a USB entry at that ID. However,
physically I have just two USB ports. So I decided to re-modify my
dsdt.asl by removing that particular entry in my namespace. This
modification did help to remove the above error (only).

Just out of curiosity I did check the asl files of couple of other members
(Faye and Sourov -- Compaq presario 27xx/28xx). To my surprise I did find
similar kind of extra USB entries in their DSDT namespace (but their
kernel boot fine).

I ain't sure whatelse to do. Tght that it might be a good idea to get
familiar with ACPI specs. So after 20 kernel compiles I decided to spend
my next few days on reading ACPI 2.0 specs (www.acpi.info). Hope to find
something which can help me fix my "buggy" ACPI tables.

regards


-- 

*******************************--------------**********************************
GVS Prabhakar Reddy
Research Assistant

Model Analysis Lab (GIS Lab)
Dept. of Biological Resources Engineering 
University of Maryland 
College Park, MD, 20742.

tel: 301-405-0109 (o)
   : 301-982-7148 (r)
fax: 301-314-9023

email: reddyg-0KJXeWapumv2fBVCVOL8/A@public.gmane.org
**************************--------------------*********************************




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
