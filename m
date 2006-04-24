From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 16:10:26 +0100
Message-ID: <20060424151026.GB21096@srcf.ucam.org>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750917AbWDXPKh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dtor_core@ameritech.net
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 24, 2006 at 10:45:31AM -0400, Dmitry Torokhov wrote:

> Matthew, I would recommend not adding KEY_LID but using one of the
> switch codes (SW_0?) for the lid.

Ok, sounds good. I'll wait to see which one seems most preferable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
