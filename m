From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RESEND: [PATCH 2/3] ACPI: Send switch event on dock events
Date: Thu, 29 May 2008 09:15:10 +0100
Message-ID: <20080529081510.GB16444@srcf.ucam.org>
References: <20080528130621.GA32646@srcf.ucam.org> <20080528132152.GB32646@srcf.ucam.org> <20080528223225.51cf8298.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080528223225.51cf8298.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-acpi@vger.kernel.org

On Wed, May 28, 2008 at 10:32:25PM -0700, Andrew Morton wrote:

> Is CONFIG_ACPI_DOCK=y, CONFIG_INPUT=n possible?  I think so..

Possible, but inconsistent. I'll fix that up.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
