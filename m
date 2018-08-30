From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Subject: Re: [PATCH RFCv2 6/6] memory-hotplug.txt: Add some details about
 locking internals
Date: Thu, 30 Aug 2018 19:38:43 +0000
Message-ID: <b46f358b-8fea-b380-1978-5f3e772130d4@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-7-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180821104418.12710-7-david@redhat.com>
Content-Language: en-US
Content-ID: <9F9046A8AD873D478941CC2B49BDEB5E@namprd21.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Michal Hocko <mhocko@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-acpi@vger.kernel.org


Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

On 8/21/18 6:44 AM, David Hildenbrand wrote:
> Let's document the magic a bit, especially why device_hotplug_lock is
> required when adding/removing memory and how it all play together with
> requests to online/offline memory from user space.
> 
