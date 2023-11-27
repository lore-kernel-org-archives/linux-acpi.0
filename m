Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302B138;
	Sun, 26 Nov 2023 23:22:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A01D68AFE; Mon, 27 Nov 2023 08:22:40 +0100 (CET)
Date: Mon, 27 Nov 2023 08:22:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, rafael@kernel.org, lenb@kernel.org, robh+dt@kernel.org,
	frowand.list@gmail.com, m.szyprowski@samsung.com,
	james.quinlan@broadcom.com, iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Don't store redundant offsets
Message-ID: <20231127072240.GA28430@lst.de>
References: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 24, 2023 at 06:10:03PM +0000, Robin Murphy wrote:
> A bus_dma_region necessarily stores both CPU and DMA base addresses for
> a range, so there's no need to also store the difference between them.

Yes.  I'll add this to the for-next branch for 6.8 once I open it.

