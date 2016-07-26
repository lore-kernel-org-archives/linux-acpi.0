From: Al Stone <ahs3@redhat.com>
Subject: [RFC DSD v2 00/04] How to Use the ACPI _DSD Device Properties UUIDs
Date: Mon, 25 Jul 2016 18:34:24 -0600
Message-ID: <3a86a463-d59d-7bf4-561c-9904301c944c@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38265 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcGZAe1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jul 2016 20:34:27 -0400
Received: by mail-it0-f41.google.com with SMTP id j124so123333060ith.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jul 2016 17:34:26 -0700 (PDT)
Received: from fidelio.ahs3 (c-73-229-6-47.hsd1.co.comcast.net. [73.229.6.47])
        by smtp.gmail.com with ESMTPSA id j129sm695492itj.5.2016.07.25.17.34.24
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 17:34:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>


In the three documents that follow, we lay out a process for defining
the use cases of device properties returned by the ACPI _DSD (Device
Specific Data) object in Data Structures associated with the Device
Properties UUID [0] and the Hierarchical Properties Extension UUID [1].
The term "_DSD device properties" below refers to the data formats
associated with those two UUIDs only.  All other UUIDs used with _DSD
are outside the scope of what is described here.

The goal of these documents is to: (1) make clear to OS vendors which of
the use cases of _DSD device properties need to be supported; (2) be
clear on what those use cases should mean to the OS; and, (3) have all
OSs use the same definitions for those use cases.

The first document describes basic context and essential terminology for
the process of submitting a use case for the _DSD device properties to a
central location so that it can be reviewed and tracked.

The next document describes a database for storing the use cases of _DSD
device properties that have been reviewed and agreed upon.  The idea is
to make this database publicly available so that OS developers and
firmware creators can easily see what is already defined, what is in
use, and what is not defined.

The final document provides a formal language for describing the use
cases of _DSD device properties.  The goal is to make it relatively easy
to define new use cases of the _DSD device properties, by stating
clearly what those definitions must look like.  This also makes building
automated tools easier, allowing us to keep the process simpler, permit
validation of the content, assist with documentation, and perform basic
record keeping.

A copy of the ChangeLog is also attached so that you can see what the
primary changes were for this second version.

Why should you care?

If you write ACPI firmware, you may need to provide a _DSD object; if
you decide to create your own UUID, you will need to clearly document
the content returned by your _DSD UUID so that an OS can use it
properly.  However, if you need to use _DSD device properties, the
documents here are intended to make it clear what needs to be done so
that use cases are documented and consistent for all OSs.

If you work with OS drivers using ACPI, you may need to consult one of
the use cases of the _DSD device properties.  What these documents lay
out is a standard mechanism for describing these use cases, independent
of OS, with a uniform way to determine what is available, and what their
values are.  Ideally, there would be no need to reverse engineer, or
worse, guess at, the device properties available for a specific device.

Finally, we hope to arrive at a time when OS changes requiring use cases
in the _DSD device properties do not get accepted unless they have been
registered and documented as described here.  We want to get to the
point where use cases of _DSD device properties are unambiguous, well
documented, visible to all who need them, and usable across any number
of OSs.

If you have any comments, improvements or suggestions, let us know.  We
believe the basic content is sound, but more eyes are always better.  We
would also like to have this process up and running by August; it has
been postponed far too long as it is.

Comment here, or if you would rather, you can find the documents on
github and suggest patches there:

	https://github.com/ahs3/dsd/tree/master/documentation

Thanks.

Contributors:
    Al Stone <ahs3@redhat.com>
    Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
    Darren Hart <darren.hart@intel.com>
    David Woodhouse <david.woodhouse@intel.com>
    Mark Doran <mark.doran@intel.com>
    Rafael Wysocki <rafael.j.wysocki@intel.com>
    Robert Gough <robert.gough@intel.com>
    (...my apologies if anyone has not been mentioned...)

References:
[0]
http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
[1]
http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
