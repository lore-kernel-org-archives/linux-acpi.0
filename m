From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable,
 brightness keys
Date: Thu, 18 Dec 2014 14:50:55 +0000
Message-ID: <20141218145054.GA7745@srcf.ucam.org>
References: <5492D938.1020907@gmail.com>
 <20141218135705.GD4918@srcf.ucam.org>
 <5492DEE7.8010407@gmail.com>
 <20141218140930.GA6436@srcf.ucam.org>
 <5492E32E.2030602@gmail.com>
 <20141218142629.GA6924@srcf.ucam.org>
 <5492E5F9.2000504@gmail.com>
 <20141218143623.GA7335@srcf.ucam.org>
 <5492E753.7090505@gmail.com>
 <20141218144337.GA7613@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141218144337.GA7613@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

Oh, I see - acpi_osi= disables _OSI entirely, so we end up going down a 
different path that results in us claiming to be XP. That results in a 
bunch of changes in exposed hardware, so this patch certainly isn't 
acceptable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
