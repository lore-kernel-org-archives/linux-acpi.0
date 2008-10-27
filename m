From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Mon, 27 Oct 2008 10:07:15 -0600
Message-ID: <200810271007.16758.bjorn.helgaas@hp.com>
References: <1224702636.6784.13.camel@localhost> <1224883385.6754.116.camel@localhost> <1225093357.5189.47.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:44423 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYJ0QHU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 12:07:20 -0400
In-Reply-To: <1225093357.5189.47.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Myron Stowe <myron.stowe@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "aystarik@gmail.com" <aystarik@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, John Keller <jpk@sgi.com>

On Monday 27 October 2008 01:42:37 am Zhao Yakui wrote:
>       Of course please add some comments that the ACPI ID is always
> obtained from the processor block if the processor object is declared by
> processor.

The code's pretty straightforward already, but maybe comments like
this would address your concern:

    if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_HID)) {
+       /*
+        * Declared with "Device" statement; match _UID.
+        * Note that we don't handle string _UID yet.
+        */
        acpi_evaluate_integer(pr->handle, METHOD_NAME__UID, NULL, &value);
        pr->acpi_id = value;
    } else {
+       /* Declared with "Processor" statement; match ProcessorID */
        acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
        pr->acpi_id = object.processor.proc_id;
    }

>      If the [_UID] is a string, it should be matched with the
> ACPI processor UID string field of SAPIC table to get the processor ID.
> Now this case is not handled by your patch. Of course maybe there
> doesn't exist such a system. So we can ask the user to send the ACPIdump
> and then add the corresponding support when a string is returned by the
> _UID object. It will be great if we can add the support about this.

That would be nice, but since we don't have a machine to test it with,
Myron would be adding untested code to the kernel, and I don't think
there's much value in that.

Bjorn



