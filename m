From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable,
 brightness keys
Date: Thu, 18 Dec 2014 13:27:53 +0000
Message-ID: <20141218132753.GA4918@srcf.ucam.org>
References: <5492C5A3.8090700@gmail.com>
 <CA+5PVA43jLUp4K9=56nwgQJEyLB9EkEynb2PqfEhBWD8q-m-DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA43jLUp4K9=56nwgQJEyLB9EkEynb2PqfEhBWD8q-m-DQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Dmitry Tunin <hanipouspilot@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 18, 2014 at 08:25:42AM -0500, Josh Boyer wrote:

> What does this do to the rest of the function keys?  Does everything
> else still work as expected, including suspend and resume?

Disabling OSI completely certainly runs the risk of turning off things 
like HPET. It certainly shouldn't be done without checking the ACPI 
tables, and it really shouldn't be done at all because this is Intel's 
bug and they should just fix it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
