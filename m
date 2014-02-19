From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] drm/i915/opregion: work around buggy
 firmware that provides 8+ output devices
Date: Wed, 19 Feb 2014 16:59:06 +0800
Message-ID: <5304725A.3020909@intel.com>
References: <52FAE504.8020001@intel.com>
	<20140212103156.GC5298@nuc-i3427.alporthouse.com>
	<52FC8C01.1040002@intel.com>
	<20140213100814.GM14909@nuc-i3427.alporthouse.com>
	<CAKMK7uGN3Of2VU6_LsSLh041kkx4TrhyH0H8zvE-PRvOtzJgfg@mail.gmail.com>
	<53045DD1.5010406@intel.com> <20140219073339.GA30685@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140219073339.GA30685@srcf.ucam.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 02/19/2014 03:33 PM, Matthew Garrett wrote:
> On Wed, Feb 19, 2014 at 03:31:29PM +0800, Aaron Lu wrote:
> 
>> DID2 is in system memory region and has some assigned value like 0x400
>> when we read it. For this case it is easy since there is only one output
>> device that is of type LVDS so we can match it to connector of type eDP
>> or LVDS, suppose there is only one such connector. But for output
>> devices' whose _ADR has the value of 0x301, 0x302, etc. I have no idea
>> how to match them up to the connectors of that type as we can't be sure
>> the probe order we have used in i915 driver is the same as BIOS'.
> 
> Non-standard _ADR values are assigend by the GPU vendor, so Intel should 
> be able to provide you with the correct interpretations.

It doesn't seem the _ADR value has to be the format defined by _DOD, as
the example of the ACPI spec gives:
Method (_ADR, 0) {
    return(0x0100)
}
So that is not the problem here.

The problem is, we don't have any way of matching an ACPI output device
node to a drm connector of the same type when there are more than 1 of
those with the same type, i.e. we don't know how the index value are
assigned by BIOS.
