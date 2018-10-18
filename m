From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ACPICA: AML Parser: fix parse loop to correctly skip
 erroneous extended opcodes
Date: Thu, 18 Oct 2018 07:06:04 +0200
Message-ID: <20181018050604.GB25258@kroah.com>
References: <20181017212051.11171-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017212051.11171-1-erik.schmauss@intel.com>
Sender: stable-owner@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 17, 2018 at 02:20:51PM -0700, Erik Schmauss wrote:
> AML opcodes come in two lengths: 1-byte opcodes and 2-byte, extended opcodes.
> If an error occurs due to illegal opcodes during table load, the AML parser
> needs to continue loading the table. In order to do this, it needs to skip
> parsing of the offending opcode and operands associated with that opcode.
> 
> This change fixes the AML parse loop to correctly skip parsing of incorrect
> extended opcodes. Previously, only the short opcodes were skipped correctly.
> 
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  drivers/acpi/acpica/psloop.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
