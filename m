From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ACPI / LPSS: set an error code
Date: Tue, 7 Jul 2015 10:50:36 +0300
Message-ID: <20150707075036.GB4341@mwanda>
References: <20150703085653.GC11901@mwanda>
 <1480350.L34Aud6LIR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480350.L34Aud6LIR@vostro.rjw.lan>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 07, 2015 at 12:56:21AM +0200, Rafael J. Wysocki wrote:
> This looks insufficient to my eyes, as we leak memory here too.
> 
> What about the following instead?

Yeah.  You are, of course, correct.

regards,
dan carpenter


