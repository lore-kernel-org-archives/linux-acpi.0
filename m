From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fujitsu P2120 S3 resume - no video, lost PCI config,
 suggestions?
Date: Thu, 6 Mar 2003 08:48:57 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0303060848260.994-100000@localhost.localdomain>
References: <ebwn0k9jaab.fsf@pcedu3.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <ebwn0k9jaab.fsf-e5kh7Nd5fja2ozzinb8jHw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 6 Mar 2003, Ole Rohne wrote:

> Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org> writes:
> 
> > Defintely. However, what I was more concerned with was the fact that there
> > is a definite hang when writing PCI config space. Getting around that will
> > enable progess in saving/restoring the rest of the state..
> 
> I've added pci_driver->power_on in and call it during RESUME_POWER_ON
> from pci_device_resume. Now I can write PCI config in
> radeonfb_power_on without hanging... I'd be able to provide a patch
> shortly, unless I'm told this is not the way to do it.

That's great. Do you actually get video back when you do that? 

	-pat



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
