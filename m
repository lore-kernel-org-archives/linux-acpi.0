From: Chaskiel M Grundman <cg2v-OM76b2Iv3yLQjUSlxSEPGw@public.gmane.org>
Subject: acpi=force report
Date: Wed, 08 Oct 2003 17:46:45 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <2370000.1065649605@sphinx.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(I can't find a searchable archive of this list, nor could I find any
google-able references to acpi problems with this hardware, so I don't know
if there's really a point in sending this or not)

I have a Dell GX240 that I recently upgraded to 2.4.22-ac3. I noticed the
message about acpi blacklisting and decided to try and see what the problem
was. 

Booting this machine with acpi=force does not seem to have broken anything.
(network, video, audio, ide all seem fine)
In fact, it actually fixes an IOAPIC problem I used to have with it. when
the ioapic is configured using the MPS table, one of the usb controllers is
assigned the wrong interrupt, which makes the front usb connectors useless.
When configured using the ACPI data, it works.

So, 1) what else should I be looking for to make sure that my machine isn't
broken? 2) if it's not broken, I assume you want logs, DSDT dumps, etc.
What should I be sending?



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
